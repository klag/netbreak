import { ApiMarketPage } from './app.po';

describe('api-market App', function() {
  let page: ApiMarketPage;

  beforeEach(() => {
    page = new ApiMarketPage();
  });

  it('should display message saying app works', () => {
    page.navigateTo();
    expect(page.getParagraphText()).toEqual('app works!');
  });
});
