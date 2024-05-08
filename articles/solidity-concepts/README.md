
| Concept / Keyword      | Description                                                                                                      |
|------------------------|------------------------------------------------------------------------------------------------------------------|
| Visibility             | Specifies the accessibility of functions and state variables: `public, internal, external, private`.                |
| State Variables        | Variables that hold data persistently across function calls within a contract.                                   |
| Events                 | Mechanism for emitting and logging occurrences within a contract, often used for backend services.            |
| Modifiers              | You can define modifier and reuse it in functions. (e.g. ownerOnly)                                  |
| Inheritance            | Feature allowing contracts to inherit properties and methods from parent contracts by using `is` keyword.                               |
| Libraries              | Collections of reusable Solidity code that can be deployed independently and linked to other contracts by using `library` in the source contract and `import` keyword in the sub contract.          |
| Structs                | Custom-defined data structures allowing grouping of related data under a single name.                             |
| Enums                  | User-defined types with a finite set of possible values, useful for defining state transitions and options.       |
| Arrays                 | Data structures allowing storage of multiple values of the same type under a single variable name.                |
| Mappings               | Key-value stores allowing efficient storage and retrieval of data based on unique keys.                           |
| Error Handling         | Techniques for managing exceptions and errors in Solidity, including `revert, require, and assert` statements.     |
| require                | Statement used for validating conditions within functions, reverting execution if conditions are not met.         |
| Memory Variables       | Function variables that require explicit declaration of the memory type for temporary storage.                    |
| msg Structure          | Special global variable providing information about the current transaction, including `sender and value`.         |
| block Structure        | Special global variable providing information about the current block, including timestamp and difficulty.       |
| Solidity Assembly      | Low-level language for interacting with EVM directly, allowing fine-grained control over contract execution.     |
| View and Pure Functions | Functions that promise not to modify state (view) or read from state (pure), enabling optimizations and clarity. |
| Interface              | Blueprint for other contracts to follow, specifying the functions and events that must be implemented.            |
| Fallback Function      | Special function invoked when a contract receives Ether without a specific function call.                         |

_`If you think that any other concepts should be remembered, please leave a comment below.`_