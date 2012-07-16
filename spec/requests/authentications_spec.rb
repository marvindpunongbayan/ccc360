require 'spec_helper'

describe "Authentications" do
  
  describe "user" do
    it "redirected to CAS auth" do
      visit root_path
      page.status.should be(302)
      it "fails" do
      end
      it "succeeds" do
      end
    end
  end
end
