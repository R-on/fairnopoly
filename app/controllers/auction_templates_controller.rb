class AuctionTemplatesController < InheritedResources::Base
  
  before_filter :authenticate_user!
  before_filter :build_resource, :only => [:new, :create]
  before_filter :build_auction, :only => [:new, :edit, :create, :update]
  before_filter :setup_categories, :only => [:new, :edit, :create, :update]
  before_filter :build_questionnaires, :only => [:new, :edit, :create, :update]
  before_filter :build_transaction, :only => [:create, :update]
  
  actions :all, :except => [:show]
  
  def begin_of_association_chain
    current_user
  end
  
  def collection
    @auction_templates ||= end_of_association_chain.paginate(:page => params[:page])
  end
    
  def collection_url
    dashboard_path
  end
  
  private 
  
  def build_auction
    @auction ||= resource.auction || resource.build_auction 
  end
  
  def build_questionnaires
    @fair_trust_questionnaire ||= @auction.fair_trust_questionnaire || @auction.build_fair_trust_questionnaire
    @social_producer_questionnaire ||= @auction.social_producer_questionnaire || @auction.build_social_producer_questionnaire
  end
  
  def build_transaction
    @auction.transaction ||= PreviewTransaction.new
  end
end
