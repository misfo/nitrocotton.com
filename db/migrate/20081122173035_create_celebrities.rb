class CreateCelebrities < ActiveRecord::Migration
  def self.up
    create_table :celebrities do |t|
      t.string :name, :filename

      t.timestamps
    end

    Celebrity.create!(:name => "Arnold Schwarzenegger", :filename => "arnold_schwarzenegger.jpg")
    Celebrity.create!(:name => "Bill Cosby",            :filename => "bill_cosby.jpg")
    Celebrity.create!(:name => "Chuck Norris",          :filename => "chuck_norris.jpg")
    Celebrity.create!(:name => "Courtney Love",         :filename => "courtney_love.jpg")
    Celebrity.create!(:name => "David Hasselhoff",      :filename => "david_hasselhoff.jpg")
    Celebrity.create!(:name => "Gary Busey",            :filename => "gary_busey.jpg")
    Celebrity.create!(:name => "George W. Bush",        :filename => "george_w_bush.jpg")
    Celebrity.create!(:name => "Hillary Clinton",       :filename => "hillary_clinton.jpg")
    Celebrity.create!(:name => "Jay Leno",              :filename => "jay_leno.jpg")
    Celebrity.create!(:name => "Madonna",               :filename => "madonna.jpg")
    Celebrity.create!(:name => "Martha Stewart",        :filename => "martha_stewart.jpg")
    Celebrity.create!(:name => "Rosie O'Donnell",       :filename => "rosie_odonnell.jpg")
  end

  def self.down
    drop_table :celebrities
  end
end
