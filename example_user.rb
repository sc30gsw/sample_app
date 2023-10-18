class User
  # 4.4.5演習No.1
  attr_accessor :first_name, :last_name, :email

  def initialize(attributes = {})
    # 4.4.5演習No.1 
    @first_name  = attributes[:first_name]
    @last_name = attributes[:last_name]
    @email = attributes[:email]
  end

  # 4.4.5演習No.1
  def full_name
    "#{@first_name} #{@last_name}"
  end

  def formatted_email
    # 4.4.5演習No.1
    "#{full_name} <#{@email}>"
  end
end
