module Order
  def order
    @order = params[:order]
    @order.each_index { |i| end_of_association_chain.find(@order[i]).update_attribute(:position, i) }
    render :text=>"Ok"
  end
  
  def reorder
    @items = collection

    render "reorder"
    rescue ActionView::MissingTemplate
      render :file => "/admin/scaffold/reorder", :layout => "admin/layouts/admin"
  end
  
  private
  def collection
    @collection = end_of_association_chain.all :order=>'position'
  end
end