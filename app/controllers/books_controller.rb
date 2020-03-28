class BooksController < ApplicationController
	before_action :authenticate_user!
	before_action :correct_user, only: [:edit, :update]
	def new
		@book = Book.new
	end

	def create
		@book = Book.new(book_params)
		@books = Book.all
		@user = current_user
		@book.user_id = @user.id
        if @book.save
           flash[:notice] = "Book was successfully created."
  	       redirect_to book_path(@book)
        else
           render("books/index")
        end
	end

	def index
		@books = Book.all
		@book = Book.new
		@user = current_user
	end

	def show
		@book = Book.new
		@books = Book.find(params[:id])
		@user = @books.user
	end

	def destroy
		@book = Book.find(params[:id])
		@book.destroy
		redirect_to books_path
	end

	def edit
		@book = Book.find(params[:id])
		@user = current_user
	end

	def update
		@book = Book.find(params[:id])
		@book.update(book_params)

		if @book.save
			flash[:notice] = "You have update book successfully"
			redirect_to book_path(@book.id)
		else
			render("books/edit")
		end
	end

	private

    def correct_user
    	book = Book.find(params[:id])
    	if current_user != book.user
    		redirect_to books_path
    	end
    end

    def book_params
        params.require(:book).permit(:title, :body, :user_id)
    end
end
