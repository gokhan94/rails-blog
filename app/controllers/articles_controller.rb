class ArticlesController < ApplicationController

	before_action :set_article,  only:   [:edit, :update, :show, :destroy]
	before_action :require_user, except: [:index, :show]
	before_action :require_same_user, only: [:edit, :update, :destroy]

	## Tüm Article Listeler
	def index
		@articles = Article.paginate(page: params[:page], per_page: 3)
	end	
	## Form_for ile oluşturulan foruma yeni bir article nesnesi oluşturmasını sağladık
	def new
		@article = Article.new
	end	

	def edit
	end	

	def create
		##render plain: params[:article].inspect
		@article      = Article.new(article_params)
		@article.user = current_user
		if @article.save
			flash[:success] = "Article Successufly created"	
			redirect_to article_path(@article)
		else
			render :new	
		end
		
	end	

	def update
		if @article.update(article_params)
			flash[:success] = "Article successfuly updated"
			redirect_to article_path(@article)
		else	
			render :edit
		end
	end	


	def show
	end	

	def destroy
		@article.destroy
		flash[:danger] = "Article successfuly delete"
		redirect_to articles_path
	end	

	private

	def set_article
		@article = Article.find(params[:id])
	end	

	def article_params
		params.require(:article).permit(:title, :description, category_ids: [])
	end	

   def require_same_user
   	## Oturum açan kişi ile makale açan kişi aynımı
   	## Kullanıcı admin yetkisine sahip değilse, :edit, :update, :destroy metotlarına erişemesin
   	if current_user != @article.user && !current_user.admin?
	    flash[:danger] = "bu eylemi gerçekleştirme yetkisine sahip değilsin"
  		redirect_to root_path   		
   	end
   end	

end	