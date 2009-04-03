module ResourceControllerView
  protected
  # Used to actually pass the responses along to the controller's respond_to method.
  #
  def response_for(action)
    respond_to do |wants|
      options_for(action).response.each do |method, block|
        if block.nil?
          wants.send(method)
        else
          wants.send(method) { instance_eval(&block) }
        end
      end
    end

    rescue ActionView::MissingTemplate
      render :file => "/admin/scaffold/#{name_template}", :layout => "admin/layouts/admin"
  end

  # Set name of template
  #
  def name_template
    case self.action_name.to_s
    when "create"
      return "new"
    when "update"
      return "edit"
    else
      self.action_name.to_s
    end
  end
end