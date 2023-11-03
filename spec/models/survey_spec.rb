require 'rails_helper'

RSpec.describe Survey, type: :model do
  describe "validations" do
    it "invalid if participant_id is not unique" do
      allow(AbstractService).to receive(:validate_email).and_return({ 'quality_score' => 0.9 })
      participant = FactoryBot.create(:participant)
      survey = FactoryBot.create(:survey, participant: participant)
      survey2 = FactoryBot.build(:survey, participant: participant)
      survey2.save

      expect(survey2.save).to be false
      expect(survey2.errors[:participant_id]).to include("has already been taken")
    end
  end
end
