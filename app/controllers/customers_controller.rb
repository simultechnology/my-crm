# -*- coding: utf-8 -*-
class CustomersController < ApplicationController
  before_filter :authorize
  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @customers }
    end
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
    @customer = Customer.find(params[:id])
    #@customer_types = CustomerType.find_all_by_customer_id(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @customer }
    end
  end

  # GET /customers/new
  # GET /customers/new.json
  def new
    @customer = Customer.new
    @customer_types = [CustomerType.new]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @customer }
    end
  end

  # GET /customers/1/edit
  def edit
    @customer = Customer.find(params[:id])
    @customer_types = CustomerType.find_all_by_customer_id(params[:id])
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(params[:customer])
    @customer_types =
        CustomerType.new(
                        :customer_type => params[:customer_type],
                        :customer_type_name => params[:customer_type_name],
                        :zip_number => params[:zip_number],
                        :prefecture_cd => params[:prefecture_cd],
                        :city => params[:city],
                        :oaza => params[:oaza],
                        :town => params[:town],
                        :building_name => params[:building_name],
                        :customer_type_memo => params[:customer_type_memo])

    @customer.customer_types << @customer_types

    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: '以下の情報が登録されました。' }
        format.json { render json: @customer, status: :created, location: @customer }
      else
        format.html { render action: "new" }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /customers/1
  # PUT /customers/1.json
  def update
    @customer = Customer.find(params[:id])

    respond_to do |format|
      if @customer.update_attributes(params[:customer])
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy

    respond_to do |format|
      format.html { redirect_to customers_url }
      format.json { head :ok }
    end
  end
end
