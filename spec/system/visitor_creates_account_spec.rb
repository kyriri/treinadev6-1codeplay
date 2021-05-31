require 'rails_helper'

describe 'Visitor creates account' do
  it 'with email and password' do
    visit root_path
    click_on 'Criar conta'
    # save_page
    fill_in 'Email', with: 'jane_doe@coldmail.com'
    fill_in 'Senha', with: '12345678'
    fill_in 'Confirmar senha', with: '12345678'
    click_on 'Criar conta'
  
    expect(current_path).to eq(root_path)
    expect(page).to have_text('Login efetuado com sucesso')
    expect(page).to have_text('jane_doe@coldmail.com')
    expect(page).to_not have_link('Criar conta')
    expect(page).to_not have_link('Logar')
    expect(page).to_ have_link('Sair')
  end
end