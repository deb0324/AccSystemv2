class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :current_year, :convert_name, :current_task, :declare_e2c
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    redirect_to login_path unless current_user
  end

  def require_accountant
    redirect_to login_path unless current_user && current_user.accountant? 
  end

  # Calculate 民國 year
  def current_year
    Date.today.strftime("%Y").to_i - 1911
  end

  def name_array
    codes = User.all.order(:code).pluck(:code)
    names = User.all.order(:code).pluck(:name)
    
    length = names.length
    arr = []
    (0...length).each do |i|
      arr << "#{codes[i]} #{names[i]}"
    end
    arr
  end

  def convert_name(user)
    name = "#{user.code} #{user.name}"
  end

  def get_declare_types
    ["書審","查帳","簽證"]
  end

  def get_status
    ["現有客戶", "停業", "遷出"]
  end

  def get_task_types_chin
    ['1~2月營業稅','3~4月營業稅','5~6月營業稅','7~8月營業稅','9~10月營業稅','11~12月營業稅','扣繳憑單申報', '結算申報']
  end

  # def get_task_types_eng
  #   ["VatJan", "VatMar", "VatMay", "VatJul", "VatSep", "VatNov", "Voucher", "IncomeTax"]
  # end

  def get_task_types_eng
    ["vat_jan", "vat_mar", "vat_may", "vat_jul", "vat_sept", "vat_nov", "voucher", "income_tax"]
  end

  # def get_check_types
  #   ["Primary", "Secondary", "Recieved", "Upload"]
  # end

  def get_check_types
    ["recieved", "primary", "secondary", "accountant", "upload"]
  end

  def get_years
    ['105', '106', '107', '108', '109', '110']
  end

  def current_task
    case Date.today.strftime("%m-%d")
    when ("03-01".."03-17")
      flag = "1~2月營業稅"
    when ("05-01".."05-15")
      flag = "3~4月營業稅"
    when ("07-01".."07-17")
      flag = "5~6月營業稅"
    when ("09-01".."09-17")
      flag = "7~8月營業稅"
    when ("11-01".."11-17")
      flag = "9~10月營業稅"
    when ("01-01".."01-15")
      flag = "11~12月營業稅"
    when ("01-16".."02-05")
      flag = "11~12月營業稅"
    when ("05-16".."06-05")
      flag = "11~12月營業稅"
    else
      flag = "1~2月營業稅"
    end
  end

  def status_c2e(status)
    case status
    when "現有客戶"
      "current"
    when "停業"
      "closed"
    when "遷出"
      "moved"
    else
      "current"
    end
  end

  def status_e2c(status)
    case status
    when "current"
      "現有客戶"
    when "closed"
      "停業"
    when "moved"
      "遷出"
    else
      "現有客戶"
    end
  end

  def declare_c2e(type)
    case type
    when "書審"
      "review"
    when "查帳"
      "account"
    when "簽證"
      "visa"
    else
      "review"
    end
  end

  def declare_e2c(type)
    case type
    when "review"
      "書審"
    when "account"
      "查帳"
    when "visa"
      "簽證"
    else
      "書審"
    end
  end

  # Convert task name from Chin to Eng
  def task_c2e(task)

    case task
    when '1~2月營業稅'
      'vat_jan'
    when '3~4月營業稅'
      'vat_mar'
    when '5~6月營業稅'
      'vat_may'
    when '7~8月營業稅'
      'vat_jul'
    when '9~10月營業稅'
      'vat_sept'
    when '11~12月營業稅'
      'vat_nov'
    when '扣繳憑單申報'
      'voucher'
    when '結算申報'
      'income_tax'
    else
      redirect_to '/'
    end  
  end

  # Convert task name from Eng to Chin
  def task_e2c(task)

    case task
    when 'vat_jan'
      '1~2月營業稅'
    when 'vat_mar'
      '3~4月營業稅'
    when 'vat_may'
      '5~6月營業稅'
    when 'vat_jul'
      '7~8月營業稅'
    when 'vat_sept'
      '9~10月營業稅'
    when 'vat_nov'
      '11~12月營業稅'
    when 'voucher'
      '扣繳憑單申報'
    when 'income_tax'
      '結算申報'
    else
      '###'
    end
  end
end
