# Repository for AKS Eksempel med bruk av Terraform

Innholder et eksempel oppsett med bruk av Terraform for å sette opp AKS. 

Setter opp følgende ressurser i Azure

* Azure Kubernetes Service 
* Log Analytics
* m/Container Insight
* Diagnostics for log innsamling
* RBAC og Azure AD Integrert (husk å bytte til egen Group ID)
* Azure Policy
* Log Analytics agent installert
* Azure Defender
* Container Registry

NB: Om den skal brukes mot egen miljø, må egen GroupID defineres i aks.tf da denne peker til egen Azure AD gruppe innenfor egen tenant. 

NB: Brukes kun for test, da denne har hardkodet verdier i backend.tf

Bruk:

Last ned Terraform binær filen for å kjøre lokalt, definere en service principal som har contributer rettigheter på backend.tf filen å fyll inn de blanke verdiene. Deretter kjør Terraform init for å laste ned Azure providern å deretter kjøre terraform plan og apply for å sette opp clusteret. 
