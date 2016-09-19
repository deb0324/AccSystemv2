class Check < ActiveRecord::Base

  def total_checks
    attributes = ["recieved", "primary", "secondary", "accountant", "upload"]
    count = 0
    attributes.each do |attribute|
      if self.read_attribute(attribute)
        count = count + 1
      end
    end
    count
  end

end
