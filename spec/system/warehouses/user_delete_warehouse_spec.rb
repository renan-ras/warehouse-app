require 'rails_helper'

describe 'Usuário remove galpão' do
  it "com sucesso" do
    #
    Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, description: 'Galpão da zona portuária do Rio', address: 'Avenida do Museu do Amanhã, 1000', zip: '20100-000')
    Warehouse.create!(name: 'Sampa', code: 'SD2', city: 'RJ', area: 30_000, description: 'Galpão da zona portuária do Rio', address: 'Avenida do Museu do Amanhã, 1000', zip: '25100-000')
    #
    visit '/'
    click_on 'Rio'
    click_on 'Remover'

    #
    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso'
    expect(page).not_to have_content 'Rio'
    expect(page).not_to have_content 'SDU'
    expect(page).to have_content 'Sampa'
    expect(page).to have_content 'SD2'
  end
end
