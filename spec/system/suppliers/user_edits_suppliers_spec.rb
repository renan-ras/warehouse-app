require 'rails_helper'

#vê página de edição
#edita com sucesso
#edita com erro

describe 'Usuário ao editar Fornecedor' do
  it "vê página de edição preenchida" do
    #
    s = Supplier.create!(
      corporate_name: 'Soluções Inovadoras Ltda',
      brand_name: 'Inova Store',
      registration_number: '98.765.432/0001-01',
      full_address: 'Avenida das Inovações, 987, Distrito Criativo',
      city: 'Inovação City',
      state: 'IC',
      email: 'contato@inovastore.com'
    )

    #
    visit root_path
    within 'nav' do
      click_on 'Fornecedores'
    end
    click_on 'Inova Store'
    click_on 'Editar'

    #
    expect(current_path).to eq edit_supplier_path(s.id)

    expect(page).to have_field('Razão Social', with: 'Soluções Inovadoras Ltda')
    expect(page).to have_field('Nome Fantasia', with: 'Inova Store')
    expect(page).to have_field('CNPJ', with: '98.765.432/0001-01')
    expect(page).to have_field('Endereço', with: 'Avenida das Inovações, 987, Distrito Criativo')
    expect(page).to have_field('Cidade', with: 'Inovação City')
    expect(page).to have_field('Estado', with: 'IC')
    expect(page).to have_field('E-mail', with: 'contato@inovastore.com')
  end

  it "edita com sucesso" do
    #
    s = Supplier.create!(
      corporate_name: 'Soluções Inovadoras Ltda',
      brand_name: 'Inova Store',
      registration_number: '98.765.432/0001-01',
      full_address: 'Avenida das Inovações, 987, Distrito Criativo',
      city: 'Inovação City',
      state: 'IC',
      email: 'contato@inovastore.com'
    )

    #
    visit edit_supplier_path(s.id)
    fill_in "Estado",	with: "PR"
    fill_in "Razão Social",	with: "Innovative Solutions LLC"

    click_on 'Enviar'

    #
  end
  
  it "não edita e tem erro" do
    
  end
  
end