import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { TableHomeComponent } from './tableHome.component';

describe('TableHomeComponent', () => {
  let component: TableHomeComponent;
  let fixture: ComponentFixture<TableHomeComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ TableHomeComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(TableHomeComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
