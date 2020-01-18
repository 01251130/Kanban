require 'test_helper'

class CardControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @list = lists(:one)
    @card = cards(:one_one)
  end
  
  test "aa" do
    
    patch list_card_path(@list.id, @card), params: {password:  "",
                                                            password_confirmation:  "",
                                                            admin:  true,
                                                          }  end
end
