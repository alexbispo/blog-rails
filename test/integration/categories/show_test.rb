require_relative 'categories_test_base'

class ShowTest < CategoriesTestBase
  test "show category from categories" do
    visit categories_path
    page.click_link 'Mostrar'
    assert page.has_text? 'Categoria'
    assert page.has_text? 'Nome'
    assert page.has_text? 'Descrição'
    assert page.has_link? 'Editar'
    assert page.has_link? 'Remover'
    assert page.has_link? 'Voltar'
  end

  test "go to edit page from show" do
    visit category_path(@category)
    page.click_link 'Editar'
    assert_equal edit_category_path(@category), current_path
  end

  test "confirm delete from show" do
    Capybara.current_driver = :webkit
    visit category_path(@category)

    page.accept_confirm 'Confirma esta ação?' do
      page.click_link 'Remover'
    end

    assert page.has_text? 'Registro removido com sucesso!'
    assert_equal categories_path, current_path
  end

  test "dismiss delete action from show" do
    Capybara.current_driver = :webkit
    visit category_path(@category)

    page.dismiss_confirm 'Confirma esta ação?' do
      page.click_link 'Remover'
    end

    assert_equal category_path(@category), current_path
  end

  test "go back from show" do
    visit categories_path
    page.click_link('Mostrar')
    page.click_link('Voltar')
    assert_equal categories_path, current_path
  end
end
