# -*- coding: utf-8 -*-
module ApplicationHelper

  def leadsource_options
    make_options('a')
  end

  def status_options
    make_options('b')
  end

  def priority_options
    make_options('c')
  end

  def customer_type_options
    make_options_without_null_opiton('d')
  end

  def prefecture_options
    make_options('e')
  end

  def prefecture_group_options
    prefecture_cds = prefecture_options
    options = [
      ['北海道', [prefecture_cds[1]]],
      ['東北', prefecture_cds[2..7]],
      ['関東', prefecture_cds[8..14]],
      ['北陸', prefecture_cds[15..17]],
      ['甲信越', prefecture_cds[18..20]],
      ['東海', prefecture_cds[21..24]],
      ['関西', prefecture_cds[25..30]],
      ['中四国', prefecture_cds[31..39]],
      ['九州', prefecture_cds[40..46]],
      ['沖縄', [prefecture_cds[47]]]]
  end

  private
  def make_options(code_type)
    codes = Code.order('code_order ASC').where(:del_flg => false).find_all_by_code_type(code_type)

    options = codes.collect {|c| [c.code_name, c.code_val] }
    options.unshift(['',''])
  end
  
  private
  def make_options_without_null_opiton(code_type)
    codes = Code.order('code_order ASC').where(:del_flg => false).find_all_by_code_type(code_type)

    options = codes.collect {|c| [c.code_name, c.code_val] }
  end

  def leadsource_name(code_val)
    get_code_name('a', code_val)
  end

  def status_name(code_val)
    get_code_name('b', code_val)
  end

  def priority_name(code_val)
    get_code_name('c', code_val)
  end

  def customer_type_cd_name(code_val)
    get_code_name('d', code_val)
  end

  def prefecture_name(code_val)
    get_code_name('e', code_val)
  end

  private
  def get_code_name(code_type, code_val)
    if code_val != nil
      Code.find(:first, :conditions => "code_type = '#{code_type}' and code_val = '#{code_val}'").code_name
    end
  end

  # 日本語日付選択
  def date_select_jp(object_name, method, options={ })
    options[:use_month_numbers] = true unless options[:use_month_numbers]
    t = date_select(object_name, method, options)
    if options[:discard_day]
      t.sub(/<\/select>(.+?)<\/select>/m, "</select>年\\1</select>月")
    else
      t.sub(/<\/select>(.+?)<\/select>(.+?)<\/select>/m, "</select>年\\1</select>月\\2</select>日")
    end
  end

end
