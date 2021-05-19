require 'rails_helper'

shared_examples_for "access a resource without signed in" do
  it 'should redirect to sign_in' do
    expect(subject).to redirect_to(new_user_session_path)
    expect(response.body).to match(/You are being (.)*redirected/i)
  end
end
