class Public::AddressesController < ApplicationController
  def index
    @addresses = Addresses.all
  end

  def edit
  end
end
