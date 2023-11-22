INSERT INTO article VALUES 
    ('ART001', 'RR', 'Riz Rouge', 1, 'kg'),
    ('ART002', 'RBS', 'Riz Blanc Stock', 2, 'kg');

INSERT INTO magasin VALUES
    ('MG001', 'M1'),
    ('MG002', 'M2');

INSERT INTO entree VALUES
    ('E0001', '2020-09-01', 1000, 2000, 'MG001', 'ART001'),
    ('E0002', '2021-11-01', 500, 2300, 'MG001', 'ART001'),
    ('E0003', '2021-12-03', 200, 2500, 'MG001', 'ART001'),
    ('E0004', '2021-11-01', 500, 1500, 'MG001', 'ART002'),
    ('E0005', '2021-11-03', 1400, 1700, 'MG001', 'ART002'),
    ('E0006', '2021-11-05', 1000, 2500, 'MG001', 'ART002');

INSERT INTO sortie VALUES
    ('S0001', '2021-12-02', 1200, 'MG001', 'ART001', 10);

INSERT INTO mouvement VALUES
    ('S0001', 'E0001', 1000),
    ('S0001', 'E0002', 200);

INSERT INTO validation_mouvement (id_validation, date, id_employe, id_sortie) VALUES
    ('V0001', '2021-12-11', 'EMP001', 'S0001');