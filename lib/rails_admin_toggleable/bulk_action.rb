module RailsAdmin
  module Config
    module Actions
      class BulkToggleBase < Base
        # Is the action acting on the root level (Example: /admin/contact)
        register_instance_option :collection? do
          true
        end
        
        register_instance_option :bulkable? do
          true
        end

        register_instance_option :link_icon do
          'icon-move'
        end

        register_instance_option :http_methods do
          [:post]
        end
      end
      
      class BulkToggle < BulkToggleBase
        register_instance_option :controller do
          Proc.new do |klass|
            @objects = list_entries(@model_config, :toggle)
            @objects.each do |obj|
              obj.send("#{@action.class.meth}=", !obj.send(@action.class.meth))
              obj.save!
            end
            redirect_to :back
          end
        end
      end
      class BulkEnable < BulkToggleBase
        register_instance_option :controller do
          Proc.new do |klass|
            @objects = list_entries(@model_config, :toggle)
            @objects.each do |obj|
              obj.send("#{@action.class.meth}=", true)
              obj.save!
            end
            redirect_to :back
          end
        end
      end
      class BulkDisable < BulkToggleBase
        register_instance_option :controller do
          Proc.new do |klass|
            @objects = list_entries(@model_config, :toggle)
            @objects.each do |obj|
              obj.send("#{@action.class.meth}=", false)
              obj.save!
            end
            redirect_to :back
          end
        end
      end
    end
  end
end
