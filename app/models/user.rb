class User < ActiveRecord::Base
  has_many :customers

  has_secure_password

  def accountant?
    self.code == "Y01" || self.code == "Y02"
  end

  def closed?
    self.code == "Z01"
  end

  def moved?
    self.code == "Z99"
  end

  def permission?(task, check_type)
    if self.id == Customer.find(task.customer_id).officer_id && !(self.id == Customer.find(task.customer_id).leader_id || self.id == Customer.find(task.customer_id).manager_id)
      (check_type == "recieved" || check_type == "primary")
    else
      if check_type == "accountant"
        self.accountant?
      else
        true
      end
    end
  end

  def completed?(check, check_type)
    case check_type
    when "recieved"
      true
    when "primary"
      check.read_attribute("recieved")
    when "secondary"
      check.read_attribute("primary")
    when "accountant"
      check.read_attribute("secondary")
    when "upload"
      if check_type == "income_tax"
        check.read_attribute("accountant")
      else
        check.read_attribute("secondary")
      end
    else
      false
    end
  end
end
