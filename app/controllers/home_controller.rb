class HomeController < ApplicationController
  def index
    if(params[:tab])
      if(params[:tab]=='default')
        @users = User.order('id desc').page(params[:page]).per(12)
        @user_count=User.count
      end

      if(params[:tab]=='notice')
        @notices = Notice.order('id desc').page(0).per(12)
      end

      if(params[:tab]=='article')
        @articles = Article.order('id desc').page(0).per(12)
      end
    else
      @users = User.order('id desc').page(params[:page]).per(12)
      @user_count=User.count
    end

    @models=Model.order('id desc').page(0).per(5)
    @reports = Report.order('id desc').page(0).per(5)
    @compliments = Compliment.order('id desc').page(0).per(5)

    respond_to do |format|
      format.html
      format.json
    end
  end

  def kbsmind
    @title='KB 임직원의 마음'
    @meta_description='일하기 짜증나고 횡령할꺼 찾아야되는데 거지새끼들이 자꾸 대출해달라고 오네?'

    respond_to do |format|
      format.html { render layout: layout}
    end
  end

  def privacy

  end

  def feed
    @reports = Report.all.where(:enable=>true)
    @compliments = Compliment.all.where(:enable=>true)
    @users = User.all.where(:enable=>true)
    respond_to do |format|
      format.rss { render :layout => false }
    end
  end
end
