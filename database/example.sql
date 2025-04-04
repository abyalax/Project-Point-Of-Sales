SELECT r.name_role, p.name 
FROM roles r
JOIN role_permissions rp ON r.id_role = rp.id_role
JOIN permissions p ON rp.id_permission = p.id;
