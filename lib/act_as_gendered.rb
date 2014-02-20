module ActAsGendered
  GENDERS = ['male', 'female']

  def self.included(base)
    base.extend(ActAsGenderedMethods)
  end

  module ActAsGenderedMethods
    def act_as_gendered options={}
      config = {:allow_nil => false}
      config.merge(options) if options.is_a?(Hash)

      extend ClassMethods
      include InstanceMethods

      if config[:allow_nil]
        validates_inclusion_of :gender, :in => (GENDERS + nil)
      else
        validates_inclusion_of :gender, :in => GENDERS
      end
    end
  end

  module ClassMethods
    def is_gendered?
      true
    end
  end

  module InstanceMethods
    def is_male
      gender = 'male'
    end

    def is_female
      gender = 'female'
    end

    def is_male?
      gender == 'male'
    end

    def is_female?
      gender == 'female'
    end
  end
end
