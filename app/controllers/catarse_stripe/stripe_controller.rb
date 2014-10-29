module CatarseStripe
  class StripeController < ::ApplicationController
    SCOPE = "projects.backers.checkout"
    layout :false

    helper_method :oauth_client

    #Makes the call to @client.auth_code.authorize_url from auth.html.erg
    def auth
      @stripe_user = current_user
      respond_to do |format|
        format.html
        format.js
      end
    end

    #Brings back the authcode from Stripe and makes another call to Stripe to convert to a authtoken
    def callback
      @stripe_user = current_user
      code = params[:code]

      @response = oauth_client.auth_code.get_token(code, {
      :headers => {'Authorization' => "Bearer #{ENV['STRIPE_SEC_KEY']}"} #Platform Secret Key
      })

      #Save PROJECT owner's new keys
      @stripe_user.stripe_access_token = @response.token
      @stripe_user.stripe_key = @response.params['stripe_publishable_key']
      @stripe_user.stripe_userid = @response.params['stripe_user_id']
      @stripe_user.save

      return redirect_to auth_stripe_index_path
    rescue Stripe::AuthenticationError => e
      ::Rollbar.error(e, :error_class => "Stripe #Pay Error", :error_message => "Stripe #Pay Error: #{e.inspect}", :parameters => params) rescue nil
      Rails.logger.info "-----> #{e.inspect}"
      flash[:error] = e.message
      return redirect_to main_app.user_path(@stripe_user)
    end

    def review
    end

    def charge
      @backer = contribution

      respond_to do |format|
        format.html
        format.js
      end
    end

    def pay
      begin
        access_token = contribution.project.stripe_access_token #Project Owner SECRET KEY
        customer = Stripe::Customer.create(
          {
            email: contribution.payer_email,
            card: params[:stripeToken]
          },
          access_token
        )

        contribution.update_attributes({
          payment_token: customer.id,
          payment_method: 'Stripe',
          confirmed_at: Time.now.utc
        })
        contribution.confirm!

        flash[:success] = I18n.t('success', scope: SCOPE)
        redirect_to main_app.project_backer_path(contribution.project, contribution)
      rescue => e
        flash[:failure] = I18n.t('stripe_error', scope: SCOPE)
        ::Rollbar.error(e) rescue nil
        redirect_to main_app.new_project_backer_path(contribution.project)
      end
    end

    def cancel
      flash[:failure] = I18n.t('stripe_cancel', scope: SCOPE)
      redirect_to main_app.new_project_backer_path(contribution.project)
    end

    protected

    def contribution
      @contribution ||= current_user.backs.find(params[:id])
    end

    def oauth_client
      @client ||= OAuth2::Client.new((ENV['STRIPE_CLIENT_ID']), (ENV['STRIPE_CLIENT_TOKEN']), {
        :site => 'https://connect.stripe.com',
        :authorize_url => '/oauth/authorize',
        :token_url => '/oauth/token'
      })
    end

    def gateway
      @gateway ||= CatarseStripe::Gateway.instance
    end
  end
end
