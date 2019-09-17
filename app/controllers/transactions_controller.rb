class TransactionsController < ApplicationController

  def index
    @transactions = Transaction.all
  end

  def new
  end

  def create
    if params[:cnab_file]
      CnabParserJob.perform_later(params[:cnab_file].path) 
      flash.now[:info] = "File imported successfully"
    else
      flash.now[:error] = "Your must select a file first"
    end 
    render :new 
  end
end
