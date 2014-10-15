class Employee
  attr_reader :name, :title, :salary, :boss

  def initialize(name, title, salary, boss)
    @name, @title, @salary, @boss = name, title, salary, boss
    @boss.all_employees << self unless @boss.nil?
  end

  def bonus(multiplier)
    salary * multiplier
  end
end

class Manager < Employee
  attr_reader :all_employees

  def initialize(name, title, salary, boss)
    super
    @all_employees = []
  end

  # def bonus(multiplier)
  #   team_salary * multiplier
  # end

  # def team_salary
  #   @all_employees.inject(0) do |team_salary, employee|
  #     team_salary + employee.salary
  #   end
  # end
  
  def salary
    @salary + @all_employees.map(&:salary)
  end
end



