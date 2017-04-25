import { ApimarketPage } from './app.po';

describe('apimarket App', () => {
  let page: ApimarketPage;

  beforeEach(() => {
    page = new ApimarketPage();
  });

  it('should display message saying app works', () => {
    page.navigateTo();
    expect(page.getParagraphText()).toEqual('app works!');
  });
});
