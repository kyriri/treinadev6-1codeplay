require 'rails_helper'

describe 'Account management' do
  context 'registration' do
    it 'with email and password' do
      visit root_path
      click_on 'Criar conta'
      # save_page
      fill_in 'Email', with: 'jane_doe@coldmail.com'
      fill_in 'Senha', with: '12345678'
      fill_in 'Confirmar senha', with: '12345678'
      within 'form' do   # it's a CSS selector
        click_on 'Criar conta'
      end
    
      expect(current_path).to eq(root_path)
      expect(page).to have_text('Login efetuado com sucesso')
    end

    xit 'without all mandatory fields' do
    end

    xit 'with email already registered' do
    end
        
    xit 'when password confirmation doesn\'t match password' do
    end

  end

  context 'log in' do
    it 'with email and password' do
      User.create!(email: 'jane_doe@coldmail.com',
                   password: '12345678',
                  )
      visit root_path
      click_on 'Entrar'
      # save_page
      fill_in 'Email', with: 'jane_doe@coldmail.com'
      fill_in 'Senha', with: '12345678'
      within 'form' do 
        click_on 'Entrar'
      end
    
      expect(page).to have_text('Login efetuado com sucesso')
      expect(page).to have_text('jane_doe@coldmail.com')
      expect(page).to_not have_link('Criar conta')
      expect(page).to_not have_link('Entrar')
      expect(page).to have_link('Sair')
    end

    it 'with invalid credentials' do
      visit root_path
      click_on 'Entrar'
      # save_page
      fill_in 'Email', with: 'jane_doe@coldmail.com'
      fill_in 'Senha', with: '12345678'
      click_button 'Entrar'
    
      expect(page).to have_text('Email ou senha inválida')
      expect(page).to have_link('Criar conta')
      expect(page).to have_link('Entrar')
    end
  end

  context 'sign out' do
    it 'succesfully' do
      test_user = User.create!(email: 'jane_doe@coldmail.com',
                               password: 'love-me_love-me',
                              )
      login_as test_user, scope: :user # TODO update tests so only logged in users can perform sensitive tasks
      visit root_path
      click_link 'Sair'

      expect(page).to have_text('Saiu com sucesso.')
      expect(page).to_not have_text('jane_doe@coldmail.com')
      expect(page).to have_link('Criar conta')
      expect(page).to have_link('Entrar')
      expect(page).to_not have_link('Sair')
    end
  end
end