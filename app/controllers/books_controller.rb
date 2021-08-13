class BooksController < ApplicationController

  def index
    @books = Book.all
    @newbook = Book.new
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @newbook = Book.new
    @user = @book.user

  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render "edit"
    else
      redirect_to books_path
    end
  end

  def create
    @books = Book.all
    @newbook = Book.new(book_params)
    @newbook.user_id = current_user.id
    @user = current_user
    if @newbook.save
      redirect_to book_path(@newbook), notice: "You have creatad book successfully."
    else
      render :index
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end


end
