## What is Go mock
Go mock is a mocking framework that allows developers to create mock structs for our interfaces and define their behavior. 

For example, it can help us generate the mock implementatoins for Reponsitory and define the expected output based on the certain inputs.

Original repo: https://github.com/golang/mock

Now it's no longer maintained, so we should use https://github.com/uber-go/mock instead.

## Installation
```shell
go install go.uber.org/mock/mockgen@latest
```

## Key features
- **Mock Generation**: gomock includes a tool called mockgen that automatically generates mock implementations of interfaces.
- **Flexible Expectations**: With gomock, you can define precise expectations on the behavior of mock objects, such as:
    - The arguments it should receive
    - And the values it should return
    - Specific number of times, min or max number of times a method should be called
    
## Mockgen command
Follow this document to understand how to use `mockgen` CLI:

https://github.com/uber-go/mock?tab=readme-ov-file#running-mockgen

## Usage
Suppose you have a `IUserRepo` interface with some methods:

**ports.go**
```go
package user

type IUserRepo interface {
	GetUserByID(id int) (*User, error)
	Insert(user User) error
	Update(id int, user User) error
}
```

**domain.go**
```go
package user

type User struct {
	ID   int
	Name string
}

```

**service.go**

```go
package user

import "fmt"

type UserService struct {
	repo IUserRepo
}

var invalidUserIDError = fmt.Errorf("invalid user id")

func (u *UserService) Upsert(user User) error {
	if user.ID <= 0 {
		return invalidUserIDError
	}
	existingUser, err := u.repo.GetUserByID(user.ID)
	if err != nil {
		return err
	}
	if existingUser == nil {
		return u.repo.Insert(user)
	}

	return u.repo.Update(user.ID, user)
}

```

**1. Run mockgen to generate mock instnace**
```bash
go run go.uber.org/mock/mockgen@latest -source=interface.go -destination=mock.go -package=user
```

- `source`: Specifies the file containing the Repository interface.
- `destination`: Specifies the file where the generated mock code will be written.
- `package`: Specifies the package name for the generated mock.

**2. Specify Expectations**

**service_test.go**

```go
package user

import (
	"go.uber.org/mock/gomock"
	"github.com/stretchr/testify/assert"
	"testing"
)

func TestUpsertUser(t *testing.T) {
	mockCtl := gomock.NewController(t)
	defer mockCtl.Finish()

	tests := []struct {
		name                 string
		user                 User
		specifyFunctionCalls func(mock *MockIUserRepo)
		expectedError        error
	}{
		{
			user: User{ID: 1, Name: "User 1"},
			name: "Should insert",
			specifyFunctionCalls: func(mockRepo *MockIUserRepo) {
				mockRepo.EXPECT().GetUserByID(1).Return(nil, nil).Times(1)
				mockRepo.EXPECT().Insert(User{ID: 1, Name: "User 1"}).Return(nil).Times(1)
			},
		},
		{
			name: "User existed - Should update",
			user: User{ID: 1, Name: "New User Name"},
			specifyFunctionCalls: func(mockRepo *MockIUserRepo) {
				mockRepo.EXPECT().GetUserByID(1).Return(&User{ID: 1, Name: "User 1"}, nil).Times(1)
				mockRepo.EXPECT().Update(1, User{ID: 1, Name: "New User Name"}).Return(nil).Times(1)
			},
		},
		{
			expectedError: invalidUserIDError,
		},
	}

	for _, test := range tests {
		t.Run(test.name, func(t *testing.T) {
			mockRepo := NewMockIUserRepo(mockCtl)
			if test.specifyFunctionCalls != nil {
				test.specifyFunctionCalls(mockRepo)
			}
			userService := UserService{repo: mockRepo}
			err := userService.Upsert(test.user)
			assert.Equal(t, test.expectedError, err)
		})
	}
}

```

In the testing file above:
- the `specifyFunctionCalls` allows us to customize mock function expectation, which functions must be called and how many times these functions must be called.
- If you try adding a redudant function into the `specifyFunctionCalls` specification (e.g. adding `mockRepo.EXPECT().Update(....)` in the first test), your test will fail due to the error: `missing call(s)`.
- If your service call a function that has not been specified, your test will fail due to the error: `there are no expected calls of the method "Insert" for that receiver`.


## Source code

https://github.com/huantt/gomock-demo