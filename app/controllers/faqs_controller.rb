class FaqsController < BoardController
  before_action :set_faq, only: [:show]

  def initialize(*params)
    super(*params)
    @controller_name=t('activerecord.models.faq')
    @title=@controller_name
    @page_itemtype='http://schema.org/QAPage'    
  end

  # GET /faqs
  # GET /faqs.json
  def index
    @faq_categories = FaqCategory.all

    if(params[:faq_category_id])
      @categoryId=params[:faq_category_id].to_i
    else
      if @faq_categories[0]
        @categoryId=@faq_categories[0].id.to_i
      else
        @categoryId=nil
      end
    end

    @faqs = Faq.where(:faq_category_id=>@categoryId).order('id desc').page(params[:page]).per(10)

    admin=false
    if(current_user)
      if(current_user.admin)
        admin=true
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: {:faqs=>@faqs,:admin=>admin} }
    end
  end

  # GET /faqs/1
  # GET /faqs/1.json
  def show
    @faq_categories = FaqCategory.all

    if(params[:id])
      @faq = Faq.find(params[:id])
    end

    @title=@faq.title
    @meta_description=@faq.faq_content.content

    if(params[:faq_category_id])
      @categoryId=params[:faq_category_id].to_i
    else
      @categoryId=@faq.faq_category_id
    end

    @faqs = Faq.where(:faq_category_id=>@categoryId).order('id desc').page(params[:page]).per(10)

    admin=false
    if(current_user)
      if(current_user.admin)
        admin=true
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @faq.faq_content}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_faq
      @faq = Faq.find(params[:id])
    end
end
