require 'rails_helper'

RSpec.describe "Participants", type: :system do
  before do
    driven_by(:rack_test)
    allow(AbstractService).to receive(:validate_email).and_return({ 'quality_score' => 0.8 })
  end

  scenario 'Participant subscribes to newsletter' do
    visit new_participant_path

    fill_in t('participants.form.email'), with: 'challengemicolet@gmail.com'
    check t('participants.form.women_fashion')
    check t('participants.form.men_fashion')
    click_button t('participants.form.subscribe_me')

    expect(page).to have_content(t('participants.ask_for_survey.would_you_like_to_answer_a_survey'))
  end

  scenario 'Participant subscribes to newsletter and answer Survey' do
    visit new_participant_path

    fill_in t('participants.form.email'), with: 'challengemicolet@gmail.com'
    check t('participants.form.women_fashion')
    check t('participants.form.men_fashion')
    click_button t('participants.form.subscribe_me')
    expect(page).to have_content(t('participants.ask_for_survey.would_you_like_to_answer_a_survey'))

    click_link t('participants.ask_for_survey.btn_yes')
    expect(page).to have_content(t('surveys.form.question1'))
  
    fill_in t('surveys.form.question1'), with: 'Answer 1'
    click_button t('next_button')
    expect(page).to have_content(t('surveys.form.question2'))
  
    fill_in t('surveys.form.question2'), with: 'Answer 2'
    click_button t('next_button')
    expect(page).to have_content(t('surveys.form.question3'))

    fill_in t('surveys.form.question3'), with: 'Answer 3'
    click_button t('next_button')
    expect(page).to have_content(t('surveys.form.question4'))

    fill_in t('surveys.form.question4'), with: 'Answer 4'
    click_button t('submit_button')
    expect(page).to have_content(t('congrats_completion'))
  end

  scenario 'Participant subscribes to newsletter and does not answer Survey' do
    visit new_participant_path

    fill_in t('participants.form.email'), with: 'challengemicolet@gmail.com'
    check t('participants.form.women_fashion')
    check t('participants.form.men_fashion')
    click_button t('participants.form.subscribe_me')

    expect(page).to have_content(t('participants.ask_for_survey.would_you_like_to_answer_a_survey'))

    click_link t('participants.ask_for_survey.btn_no')
    expect(page).to have_content(t('thanks'))
  end

  scenario 'Fail subscription cause Abstract Response is less than 0.7' do
    allow(AbstractService).to receive(:validate_email).and_return({ 'quality_score' => 0.6 })
    visit new_participant_path

    fill_in t('participants.form.email'), with: 'test@example.com'
    check t('participants.form.women_fashion')
    check t('participants.form.men_fashion')
    click_button t('participants.form.subscribe_me')

    expect(page).to have_content("Your Email address is invalid. Please try again")
  end
end
