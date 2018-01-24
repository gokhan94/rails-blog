class ArticlesController < ApplicationController
	def new
		##  new.html.erb - form_for ile oluşturulan foruma gönderdik
		@article = Article.new
	end	

	def create
		##render plain: params[:article].inspect
		@article = Article.new(article_params)
		@article.save
		redirect_to article_path(@article)
	end	

	private
	def article_params
		params.require(:article).permit(:title, :description)
	end	

end	