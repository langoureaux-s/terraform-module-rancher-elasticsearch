locals {
  stack_id    = "${compact(concat(coalescelist(rancher_stack.this_master.*.id, rancher_stack.this_client.*.id, rancher_stack.this_data.*.id, rancher_stack.this_all.*.id), list("")))}"
  stack_name  = "${compact(concat(coalescelist(rancher_stack.this_master.*.name, rancher_stack.this_client.*.name, rancher_stack.this_data.*.name, rancher_stack.this_all.*.name), list("")))}"
}


output "stack_id" {
  value = "${join("", local.stack_id)}"
}

output "stack_name" {
  value = "${join("", local.stack_name)}/elasticsearch"
}