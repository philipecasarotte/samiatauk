module ActiveRecord
  module Acts
    module SEO
      def self.included(base)
        base.extend(ClassMethods)
      end
      
      module InstanceMethods
        def metatag
          seo || build_seo
        end
        
        def save_metatag
          metatag.save
        end
        
        def metatag_title
          metatag.title
        end
        
        def metatag_description
          metatag.description
        end
        
        def metatag_keywords
          metatag.keywords
        end
        
        def metatag_title=(title)
          metatag.title=title
        end
        
        def metatag_description=(description)
          metatag.description=description
        end
        
        def metatag_keywords=(keywords)
          metatag.keywords=keywords
        end
        
        def metatags
          mt = []
          mt << ['description', metatag.description] rescue nil
          mt << ['keywords', metatag.keywords] rescue nil
          mt
        end
      end
      
      module ClassMethods
        def acts_as_seo
          include ActiveRecord::Acts::SEO::InstanceMethods
          
          options = {:as => :metatagable, :class_name => "Metatag"}
          if Rails.version < "2.3.2"
            before_save :save_metatag
          else
            options[:autosave] = true
          end
          has_one :seo, options
        end
      end
    end
  end
end