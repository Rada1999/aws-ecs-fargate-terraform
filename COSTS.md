# Cost Breakdown

All numbers are approximations for us-east-1, as of build time. Actual costs vary with usage. AWS Free Tier applies to new accounts for the first 12 months and reduces most of these to $0.

## If left running 24/7

| Resource | Monthly cost | Notes |
|---|---|---|
| NAT Gateway | ~\$32 | ~\$0.045/hr + data-processing charges |
| ALB | ~\$18 | ~\$0.0225/hr + LCU charges |
| 3 × Interface VPC Endpoints (ECR API, ECR DKR, CloudWatch Logs) | ~\$21 | ~\$0.01/hr per endpoint per AZ |
| ECS Fargate (2 tasks, 0.25 vCPU, 0.5 GB each) | ~\$18 | ~\$0.012/hr per task |
| CloudFront | Variable | \$0.085/GB for first 10 TB out (PriceClass_100) |
| Elastic IP (attached to NAT) | Free | Free while attached |
| ECR storage | ~\$0.10 | Lifecycle policy keeps last 5 images |
| CloudWatch Logs | ~\$0.50 | 7-day retention, low volume |
| **Total (idle, running 24/7)** | **~\$90/month** | |

## Per active build/test session (2–4 hrs)

| Resource | Approx cost |
|---|---|
| NAT Gateway | ~\$0.20 |
| ALB | ~\$0.10 |
| Interface endpoints | ~\$0.10 |
| Fargate tasks | ~\$0.05 |
| CloudFront | <\$0.01 |
| **Total per session** | **~\$0.50–\$1.50** |

## Cost optimization already applied

- **Single NAT** instead of per-AZ (saves ~\$32/month, trade-off documented in README)
- **CloudFront PriceClass_100** limits edge locations to NA + Europe
- **ECR lifecycle policy** deletes images older than the last 5 pushes
- **CloudWatch Logs 7-day retention** vs default 60+ days
- **Fargate at minimum sizing** (256 CPU / 512 MB)
- **VPC endpoints for AWS-service traffic** eliminates NAT data-processing charges for ECR pulls and log writes

## Guardrails

- $30/month AWS Budget alert at 80% threshold set on account
- `terraform destroy` after each build session; state is stateless (rebuilds in ~10 min)
