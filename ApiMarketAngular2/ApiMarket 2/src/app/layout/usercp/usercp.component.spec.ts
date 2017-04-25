import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { UsercpComponent } from './usercp.component';

describe('UsercpComponent', () => {
  let component: UsercpComponent;
  let fixture: ComponentFixture<UsercpComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ UsercpComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(UsercpComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
