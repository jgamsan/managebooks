class AddOfertaToBids < ActiveRecord::Migration
  def change
    add_column :bids, :oferta, :string

  end
end
