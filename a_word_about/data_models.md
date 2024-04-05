# Data model notes 

- Step back and ask:
  - What problem are we trying to solve?
  - What work are we trying to improve?

    > &#x1F4D6; Mastering the Requirements Process, by Suzanne Robertson and James Robertson

- Models are representations of reality, usualy simpler in order to be able to explain complex concepts.

## Level of data abstraction
- Conceptual Model
- Logical Model
- Physical Model

## Data model Components
- Entity
  - can be thought of as Nouns
- Relationship
  - can be thought of as Verbs
- Attribute
  - For entities can be thought of as Adjective
  - For relationships can be thought of as Adverb

## Relationship Cardinality
- One to One
- One to Many
- Many to Many

## Optionality
- Mandatory
- Optional
 
## Patterns
- &#x1F6A7;

## Modeling NoSQL
- Embedded pattern for 
  - One to One
  - Bounded One to Many: Nested and repeated field (array)
- Partial Embedded pattern 
  - Bounded One to Many: Nested and repeated field (array)
  - Unbounded One to Many: Separate collections
- One-way Embeddeding
  - One side unbounded Many to Many: Nested and repeated field (array)
- Two-way Embeddeding
  - Bounded Many to Many: Two nested and repeated field (array)

Favor embedding references unless you have static information
Interesting video about [Building Data Model Relationships - NoSQL and Redis](https://www.youtube.com/watch?v=JHMulyNImj4)

## Modeling the modern data stack
- Normalized Models, Bill Inmon
- Denormalized Models
  - Star Schema, Ralph Kimball: Dimensions and facts
  - One-Big-Table (OBT): Flatten straight to wide tables
  - Data Vault 2.0: Hubs, Links, and Satellites
  - Hybrid approach

## Notation
- Barker
- Crow's foot
- Chen
- IDEF
- Bachman
- UML

See the symbols [here](https://www.gleek.io/blog/er-symbols-notations)

## Specialized Modeling Tools
- If you are lucky enough to have your company pay for one, by all means use it
- Here some tools
  - SAP PowerDesigner for Data Architects
  - erwin Data Modeler
  - DbSchema
- Look for unpaid alternatives
  - Oracle SQL Developer Data Modeler
- Beware of the silos, you can be creating your own.
- Look for ways to embed the model generation as part of the CI/CD pipelines

#
[Back to main README](../README.md)