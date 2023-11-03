require 'rails_helper'

RSpec.describe Participant, type: :model do
  
  describe "validations" do
    it "is valid with a email and preferences" do
      participant = FactoryBot.build(:participant)
      expect(participant).to be_valid
    end
  
    it "is invalid without a email" do
      participant = FactoryBot.build(:participant, email: nil)

      expect(participant).to be_invalid
      expect(participant.errors[:email]).to include("can't be blank")
    end
  
    it "invalid if email already exists" do
      FactoryBot.create(:participant, email: "test@email.com")
      participant = FactoryBot.build(:participant, email: "test@email.com")

      expect(participant).to be_invalid
      expect(participant.errors[:email]).to include("has already been taken")
    end
  end

  describe "callbacks" do
    it "invalid if no preferences are selected" do
      participant = FactoryBot.build(:participant, women_fashion_preference: false, men_fashion_preference: false, children_fashion_preference: false)
      participant.save

      expect(participant.save).to be false
      expect(participant.errors[:base]).to include("You must select at least one preference")
    end

    it "invalid if email quality_score is less than 0.7" do
      allow(AbstractService).to receive(:validate_email).and_return({ 'quality_score' => 0.6 })
      participant = FactoryBot.build(:participant)
      participant.save

      expect(participant.save).to be false
      expect(participant.errors[:base]).to include("Your Email address is invalid. Please try again.")
    end
  end
end