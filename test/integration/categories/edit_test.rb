require_relative 'categories_test_base'

class EditTest < CategoriesTestBase
  test "edit valid category" do
    visit edit_category_path(@category)
    assert page.has_text? 'Categoria'

    page.fill_in 'Nome', with: 'Café'
    page.fill_in 'Descrição', with: 'Sobre café'
    page.click_button 'Atualizar Categoria'

    assert page.has_text? 'Registro atualizado com sucesso!'
  end

  test "edit invalid category" do
    visit edit_category_path(@category)

    page.fill_in 'Nome', with: ''
    page.click_button 'Atualizar Categoria'

    assert page.has_text? 'Por favor, verifique o(s) seguinte(s) campo(s):'
  end

  test "go to categories from edit" do
    visit edit_category_path(@category)
    page.click_link 'Cancelar'

    assert_equal category_path(@category), current_path
  end

  test "confirm delete from edit" do
    Capybara.current_driver = :webkit
    visit edit_category_path(@category)

    page.accept_confirm 'Confirma esta ação?' do
      page.click_link 'Remover'
    end

    assert page.has_text? 'Registro removido com sucesso!'
    assert_equal categories_path, current_path
  end

  test "dismiss delete action from edit" do
    Capybara.current_driver = :webkit
    visit edit_category_path(@category)

    page.dismiss_confirm 'Confirma esta ação?' do
      page.click_link 'Remover'
    end

    assert_equal edit_category_path(@category), current_path
  end
end