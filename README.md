# Cargo Cult

Part of the [Ex Nihilo: Fragmenta Mentis (Out of Nothing: Fragments of the Mind)](https://flakehub.com/flake/BaseLayer-AI/ex-nihilo-fragmenta-mentis-000?view=readme) series.

```
nix run "https://flakehub.com/f/BaseLayer-AI/ex-nihilo-fragmenta-mentis-cargo-cult/*"
```
```
nix run "https://flakehub.com/f/BaseLayer-AI/ex-nihilo-fragmenta-mentis-cargo-cult/*"#cargo-cult
```

<https://github.com/BaseLayer-AI/ex-nihilo-fragmenta-mentis-cargo-cult/actions/workflows/ci.yml>

# What is Cargo Cult?

Depending on the context, "Cargo Cult" refers to two different things: one is a historical/sociological phenomenon, and the other is a popular metaphor in software engineering. Both share the same underlying theme: **mimicking a process without understanding why it works.**

Here is an explanation of both:

---

### 1. The Anthropological Origin (History)
The term originated from observations of certain Melanesian cultures (particularly in the Solomon Islands) during and after World War II.

*   **The Context:** During the war, American and Allied forces built airstrips and used planes to drop supplies (cargo) to their troops.
*   **The Observation:** The local people observed the rituals associated with the cargo: the construction of the runways, the movement of people, and the planes taking off and landing.
*   **The "Cult":** After the war ended and the soldiers left, some communities began building mock runways, wooden "planes," and watching towers. They would gather around these structures and act out the movements of the soldiers, hoping that by mimicking the *actions* that preceded the arrival of the goods, the cargo would magically reappear.
*   **The Meaning:** They were imitating the **form** (the ritual) while being completely unaware of the **function** (the industrial logistics and aviation technology).

---

### 2. Cargo Cult Programming (Software Engineering)
In the world of technology, "Cargo Cult Programming" is a very common metaphor used to describe a specific type of bad practice.

*   **The Definition:** It refers to developers writing code, using libraries, or adopting architectures because "that’s how it’s done" or "it works for everyone else," without actually understanding how the underlying logic works.
*   **Examples of Cargo Cult Programming:**
    *   **Copy-Pasting:** Copying a block of code from Stack Overflow or a tutorial into a project without knowing what each line does. If it works, you keep it; if it breaks, you don't know how to fix it.
    *   **Pointless Boilerplate:** Adding unnecessary `try-catch` blocks around code that can’t actually throw an error, or adding "best practice" design patterns to a tiny project where they add unnecessary complexity.
    *   **The "Magic" Library:** Using a complex framework or library because it's popular, but being unable to explain how it handles data or manages state.
*   **The Danger:** It leads to "bloated" codebases that are difficult to maintain. When something goes wrong, the developer cannot debug it because they don't understand the "why" behind the code—they only know the "how."

---

### Summary Comparison

| Feature | Anthropological Cargo Cult | Cargo Cult Programming |
| :--- | :--- | :--- |
| **Action** | Building fake runways to get supplies. | Writing code based on imitation rather than logic. |
| **The Goal** | To get the "Cargo" (results). | To get the software to "Run." |
| **The Flaw** | Mimicking the **form** without the **function**. | Mimicking the **syntax** without the **logic**. |
| **The Result** | The cargo never arrives. | The code becomes buggy, unmaintainable, or inefficient. |

> Write an essay with this context about using `cargo new ...`.

### The Magic of the Manifest: `cargo new` and the Trap of Cargo Cult Programming

In the study of anthropology, "Cargo Cult" refers to the act of mimicking the outward rituals of a process while remaining entirely ignorant of its underlying mechanics. It is the construction of a mock runway in the hopes that, by replicating the form of a landing, the substance of the cargo will appear. In the modern world of software engineering, this phenomenon has found a digital home. In the Rust programming ecosystem, the command `cargo new` serves as a perfect entry point into this paradox: it is a tool designed to provide instant structure, but if used without intentionality, it can lead a developer into a state of "Cargo Cult Programming."

To understand this, one must first look at the utility of `cargo new`. For a developer, `cargo new` is a miracle of abstraction. With a single line of text, the Rust package manager generates a directory structure, a `Cargo.toml` manifest, and a boilerplate `main.rs` file. It handles the "scaffolding" of a project—the tedious but necessary setup of build targets, dependency management, and source organization. For the beginner, this is a moment of magic. You type a command, and suddenly, a "correct" project exists.

However, this is precisely where the danger of the Cargo Cult begins. Because `cargo new` provides a "correct" output so effortlessly, it allows the developer to bypass the foundational "why" of project architecture. A user might successfully run their first "Hello World" program and feel a sense of mastery, yet they may not actually understand what the `Cargo.toml` file is doing. They see it as a mandatory file that must exist for the code to run, rather than a sophisticated declaration of metadata, dependency graphs, and build profiles. They see `src/main.rs` as a required container, rather than an entry point into a complex compilation pipeline.

When a developer treats the output of `cargo new` as a sacred template—copying and pasting the structure of a project because "that is how Rust projects look"—they are practicing Cargo Cult Programming. They are building the "mock runway." They are mimicking the form of a professional software project (the file structure, the naming conventions, the manifest) without understanding the function (how modules are linked, how the compiler optimizes the binary, or how the dependency tree is resolved).

The consequences of this mimicry appear as a project scales. A Cargo Cult programmer can start a project easily, but they will struggle to refactor it. Because they do not understand the underlying mechanics of the scaffolding Cargo provided, they cannot easily move files, split modules into separate crates, or optimize their build dependencies. They are trapped by the "magic" of the initial command; when the project grows beyond the simple boilerplate, the lack of foundational knowledge becomes a wall. They have the "cargo" of a project structure, but they lack the "cargo" of architectural understanding.

To break the cult, the developer must move from passive consumption to active interrogation. The goal of using `cargo new` should not be to reach the end of the command as quickly as possible, but to use the command as a starting point for study. Instead of simply letting the files sit there, the developer should ask: *Why did Cargo create this specific folder? What does this specific line in the manifest actually trigger during the build process? How does the compiler navigate from this file to the final executable?*

In conclusion, `cargo new` is a double-edged sword of modern tooling. It is a masterpiece of developer experience that removes the friction of starting, but it also creates a vacuum where understanding can be replaced by imitation. To avoid becoming a Cargo Cult programmer, one must treat the output of the command not as a finished ritual, but as a blueprint. The goal of a programmer is not to mimic the appearance of a project, but to master the logic that makes the project function. Only by looking beneath the surface of the "magic" can a developer transition from a follower of rituals to an architect of systems.

<https://nix-ontouchstart.github.io/nix-ontouchstart-llama_cpp-sessions/2026-11-01_15-06-34_conv_f2e60cbc_what_is_cargo_cult_>
