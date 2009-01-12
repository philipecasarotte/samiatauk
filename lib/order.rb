module Order
  def order
    @order = params[:order]
    @order.each_index { |i| end_of_association_chain.find(@order[i]).update_attribute(:position, i) }
    render :text=>"Ok"
  end
  
  def reorder
    @items = collection
  end
  
  private
  def collection
    @collection = end_of_association_chain.all :order=>'position', :include=>:slugs
  end
end