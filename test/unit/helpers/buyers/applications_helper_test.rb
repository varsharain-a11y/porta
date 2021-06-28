# frozen_string_literal: true

require 'test_helper'

class Buyers::ApplicationsHelperTest < ActionView::TestCase
  def setup
    @provider = FactoryBot.create(:provider_account)
    @buyer = FactoryBot.create(:buyer_account)
    @cinstance = FactoryBot.create(:cinstance)

    expects(:raw_products).returns([])
    expects(:most_recently_updated_products).returns([])
    expects(:service_plans_management_visible?).returns(true)
  end

  attr_reader :provider, :buyer, :cinstance

  test 'new_application_form_data' do

    form_data = new_application_form_data(provider: provider, buyer: buyer)

    assert form_data.key? :"create-application-path"
    assert form_data.key? :"create-application-plan-path"
    assert form_data.key? :"service-subscriptions-path"
    assert form_data.key? :"service-plans-allowed"
    assert form_data.key? :"defined-fields"
    assert form_data.key? :buyer
    assert form_data.key? :"most-recently-updated-products"
    assert form_data.key? :"products-count"

    assert_not form_data.key? :"most-recently-created-buyers"
    assert_not form_data.key? :"buyers-count"
    assert_not form_data.key? :product
    assert_not form_data.key? :errors
  end

  test 'new_application_form_data with errors' do
    form_data = new_application_form_data(provider: provider, buyer: buyer, cinstance: cinstance)

    assert form_data.key? :errors
  end
end
