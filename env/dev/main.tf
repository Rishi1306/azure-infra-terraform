module "rg_module" {
  source = "../../module_class/ResourceGroup"
  RG     = var.RG # child = var.root basically we are passing the variable to module
}

module "sa_module" {
  source     = "../../module_class/StorageAccount"
  depends_on = [module.rg_module]
  SA         = var.SA
}

module "vn_module" {
  source     = "../../module_class/VirtualNetwork"
  depends_on = [module.rg_module]
  VN         = var.VN
}

module "sn_module" {
  source     = "../../module_class/SubNetwork"
  depends_on = [module.vn_module]
  SN         = var.SN
}

module "kv_module" {
  source     = "../../module_class/KeyVault"
  depends_on = [module.rg_module]
  KV         = var.KV
}

module "kvs_module" {
  source     = "../../module_class/KeyVaultSecret"
  depends_on = [module.kv_module]
  KVS        = var.KVS
  KV         = var.KV
}

module "vm_module" {
  source = "../../module_class/VirtualMachine"

  depends_on = [module.sn_module, module.kvs_module]

  VM  = var.VM
  SN  = var.SN
  KV  = var.KV
  KVS = var.KVS
}

module "pip_module" {
  source     = "../../module_class/PuplicIP"
  depends_on = [module.rg_module]
  PIP        = var.PIP
}

module "nsgr_module" {
  source     = "../../module_class/NSGRules"
  depends_on = [module.rg_module, module.sn_module, module.vm_module]
  NSGR       = var.NSGR
  NSG        = var.NSGR
}

module "nat_module" {
  source     = "../../module_class/NatGateway"
  depends_on = [module.sn_module]
  NG         = var.NG
  SN         = var.SN
  PIP        = var.PIP
}

module "lb_module" {
  source     = "../../module_class/LoadBalancer"
  depends_on = [module.vm_module]
  LB         = var.LB
  PIP        = var.PIP
  VM         = var.VM
  VN         = var.VN

}

module "sqls_module" {
  source     = "../../module_class/SQLServer"
  depends_on = [module.rg_module, module.vn_module, module.kv_module, module.kvs_module]
  SQLS       = var.SQLS
  KV         = var.KV
  KVS        = var.KVS
}

module "sqldb_module" {
  source     = "../../module_class/SQLDB"
  depends_on = [module.rg_module, module.sqls_module]
  SQLDB      = var.SQLDB
  SQLS       = var.SQLS
}