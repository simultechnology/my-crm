# -*- coding: utf-8 -*-
class SearchController < ApplicationController
  before_filter :authorize
  def index
    @search = Hash.new
    @customertypes = CustomerType.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @customers }
    end
  end

  def search
    @search = {:select_menu => params[:select_menu],
               :name => params[:name],
               :customer_type => params[:customer_type],
               :leadsource => params[:leadsource],
               :customer_type_name => params[:customer_type_name],
               :prefecture_cd => params[:prefecture_cd],
               :city_oaza_town => params[:city_oaza_town],
               :building_name => params[:building_name]
              }
    conditions = []
    conditions.push("customers.name like '%#{@search[:name]}%'") if !@search[:name].blank?
    conditions.push("customer_type = '#{@search[:customer_type]}'") if !@search[:customer_type].blank?
    conditions.push("customers.leadsource = '#{@search[:leadsource]}'") if !@search[:leadsource].blank?
    conditions.push("customer_type_name like '%#{@search[:customer_type_name]}%'") if !@search[:customer_type_name].blank?
    conditions.push("prefecture_cd = '#{@search[:prefecture_cd]}'") if !@search[:prefecture_cd].blank?
    conditions.push("city || oaza || town like '%#{@search[:city_oaza_town]}%'") if !@search[:city_oaza_town].blank?
    conditions.push("building_name like '%#{@search[:building_name]}%'") if !@search[:building_name].blank?
    condition_part = conditions.join(" and ") if conditions.size > 0
    @customertypes = CustomerType.find(:all, :conditions => condition_part, :include => :customer, :order => 'customer_types.updated_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @customers }
    end
  end

  def contact_search
    @search = {:select_menu => params[:select_menu],
               :name => params[:name],
               :customer_type_name => params[:customer_type_name],
               :contact_name => params[:contact_name],
               :contact_name_kana => params[:contact_name_kana],
               :birthday_year => params[:contact]['birthday(1i)'],
               :birthday_month => params[:contact]['birthday(2i)'],
               :birthday_day => params[:contact]['birthday(3i)'],
               :position => params[:position],
               :favorite => params[:favorite]
    }

    Rails.logger.debug(@search[:birthday_month]);

    conditions = []
    conditions.push("customers.name like '%#{@search[:name]}%'") if !@search[:name].blank?
    conditions.push("contact_name like '%#{@search[:contact_name]}%'") if !@search[:contact_name].blank?
    conditions.push("contact_name_kana like '%#{@search[:contact_name_kana]}%'") if !@search[:contact_name_kana].blank?
    conditions.push("date_part('year', birthday) = '#{@search[:birthday_year]}'") if !@search[:birthday_year].blank?
    conditions.push("date_part('month', birthday) = '#{@search[:birthday_month]}'") if !@search[:birthday_month].blank?
    conditions.push("date_part('day', birthday) = '#{@search[:birthday_day]}'") if !@search[:birthday_day].blank?
    conditions.push("position = '#{@search[:position]}'") if !@search[:position].blank?
    conditions.push("favorite = '#{@search[:favorite]}'") if !@search[:favorite].blank?
    condition_part = conditions.join(" and ") if conditions.size > 0
    @contacts = Contact.find(:all, :conditions => condition_part, :include => :customer, :order => 'contacts.updated_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contacts }
    end
  end

  def customer_search
    respond_to do |format|
      format.html {render :layout => 'customer_search'}
      format.json { render json: @customers }
    end
  end

  def customer_search_list
    @search = {:name => params[:name],
               :customer_type => params[:customer_type],
               :leadsource => params[:leadsource],
               :customer_type_name => params[:customer_type_name],
               :prefecture_cd => params[:prefecture_cd],
               :city_oaza_town => params[:city_oaza_town],
               :building_name => params[:building_name]
    }
    conditions = []
    conditions.push("customers.name like '%#{@search[:name]}%'") if !@search[:name].blank?
    conditions.push("customer_type = '#{@search[:customer_type]}'") if !@search[:customer_type].blank?
    conditions.push("customers.leadsource = '#{@search[:leadsource]}'") if !@search[:leadsource].blank?
    conditions.push("customer_type_name like '%#{@search[:customer_type_name]}%'") if !@search[:customer_type_name].blank?
    conditions.push("prefecture_cd = '#{@search[:prefecture_cd]}'") if !@search[:prefecture_cd].blank?
    conditions.push("city || oaza || town like '%#{@search[:city_oaza_town]}%'") if !@search[:city_oaza_town].blank?
    conditions.push("building_name like '%#{@search[:building_name]}%'") if !@search[:building_name].blank?
    condition_part = conditions.join(" and ") if conditions.size > 0
    @customertypes = CustomerType.find(:all, :conditions => condition_part, :include => :customer, :order => 'customer_types.updated_at DESC')

    respond_to do |format|
      format.html {render :layout => 'customer_search'}
      format.json { render json: @customers }
    end
  end

  def show
    @customer = Customer.find(params[:id])
    @customertypes = CustomerType.find_all_by_customer_id(params[:id])
    @contacts = Contact.find_all_by_customer_id(params[:id])

    respond_to do |format|
      format.html {render :layout => 'detail'}# show.html.erb
      format.json { render json: @customer }
    end
  end

  # PUT /customers/1
  # PUT /customers/1.json
  def update
    @customer = Customer.find(params[:id])

    @search = {:name => params[:name],
               :customer_type => params[:customer_type],
               :leadsource => params[:leadsource],
               :customer_type_name => params[:customer_type_name],
               :prefecture_cd => params[:prefecture_cd],
               :city_oaza_town => params[:city_oaza_town],
               :building_name => params[:building_name]
    }

    respond_to do |format|
      if @customer.update_attributes(params[:customer])
        flash[:notice] = '以下の情報で更新されました。'
        format.html { render action: 'result', layout: 'detail' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

end
