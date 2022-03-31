# terrascan-argocd

```


Violation Details -

	Description    :	Default seccomp profile not enabled will make the container to make non-essential system calls
	File           :	k8s-deployment.yml
	Line           :	1
	Severity       :	MEDIUM

	-----------------------------------------------------------------------

	Description    :	Default seccomp profile not enabled will make the container to make non-essential system calls
	File           :	terrascan-pre-hook.yaml
	Line           :	1
	Severity       :	MEDIUM

	-----------------------------------------------------------------------

	Description    :	No tag or container image with :Latest tag makes difficult to rollback and track
	File           :	terrascan-pre-hook.yaml
	Line           :	1
	Severity       :	LOW

	-----------------------------------------------------------------------

	Description    :	Image without digest affects the integrity principle of image security
	File           :	k8s-deployment.yml
	Line           :	1
	Severity       :	MEDIUM

	-----------------------------------------------------------------------

	Description    :	Image without digest affects the integrity principle of image security
	File           :	terrascan-pre-hook.yaml
	Line           :	1
	Severity       :	MEDIUM

	-----------------------------------------------------------------------

	Description    :	Minimize Admission of Root Containers
	File           :	k8s-deployment.yml
	Line           :	1
	Severity       :	HIGH

	-----------------------------------------------------------------------

	Description    :	Minimize Admission of Root Containers
	File           :	terrascan-pre-hook.yaml
	Line           :	1
	Severity       :	HIGH

	-----------------------------------------------------------------------

	Description    :	CPU Limits Not Set in config file.
	File           :	k8s-deployment.yml
	Line           :	1
	Severity       :	Medium

	-----------------------------------------------------------------------

	Description    :	CPU Limits Not Set in config file.
	File           :	terrascan-pre-hook.yaml
	Line           :	1
	Severity       :	Medium

	-----------------------------------------------------------------------

	Description    :	Container images with readOnlyRootFileSystem set as false mounts the container root file system with write permissions
	File           :	k8s-deployment.yml
	Line           :	1
	Severity       :	MEDIUM

	-----------------------------------------------------------------------

	Description    :	Container images with readOnlyRootFileSystem set as false mounts the container root file system with write permissions
	File           :	terrascan-pre-hook.yaml
	Line           :	1
	Severity       :	MEDIUM

	-----------------------------------------------------------------------

	Description    :	CPU Request Not Set in config file.
	File           :	k8s-deployment.yml
	Line           :	1
	Severity       :	Medium
```