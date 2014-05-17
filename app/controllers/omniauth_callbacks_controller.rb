class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    oauthorize :facebook
  end
  
  def twitter
    oauthorize :twitter
  end
  
  def github
    oauthorize :github
  end
  
  def passthru
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end
  
private
 
  def oauthorize(kind)
    identity = build_identity(kind, env['omniauth.auth'])
    @user = user_for_identity(identity, current_user)
    if @user.save
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => kind
      session["devise.#{kind}_data"] = env["omniauth.auth"]
      sign_in_and_redirect @user, :event => :authentication
    end    
  end

  def build_identity(provider, access_token)
    uid    = access_token['uid']
    token  = access_token['credentials']['token']
    secret = access_token['credentials']['secret']
    email  = access_token['info']['email']
    name   = access_token['info']['name']

    auth_attr = { :provider => provider.to_s, :uid => uid, :token => token, :secret => secret, :name => name }

    case provider
    when :facebook
      auth_attr[:url] = access_token['info']['urls']['Facebook'] 
    else
      raise 'Provider #{provider} not handled'
    end    
    Identity.find_by_uid(uid) || Identity.new(auth_attr)
  end


  def user_for_identity(identity, resource=nil)
    resource ||= User.new(:name => identity.name, :email => identity.email)
    resource.identities << identity
    resource
  end
 
end